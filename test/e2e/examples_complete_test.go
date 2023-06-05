package test_test

import (
	"github.com/stretchr/testify/assert"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	teststructure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestExamplesComplete(t *testing.T) {
	t.Parallel()
	tempFolder := teststructure.CopyTerraformFolderToTemp(t, "../..", "examples/complete")
	terraformOptions := &terraform.Options{
		TerraformDir: tempFolder,
		Upgrade:      true,
		VarFiles:     []string{"example.tfvars"},
		RetryableTerraformErrors: map[string]string{
			".*empty output.*": "bug in aws_s3_bucket_logging, intermittent error",
		},
		MaxRetries:         5,
		TimeBetweenRetries: 5 * time.Second,
	}

	// Defer the teardown
	defer func() {
		t.Helper()
		teststructure.RunTestStage(t, "TEARDOWN", func() {
			terraform.Destroy(t, terraformOptions)
		})
	}()

	// Set up the infra
	teststructure.RunTestStage(t, "SETUP", func() {
		terraform.InitAndApply(t, terraformOptions)
		// Assert that the backend.tf file exists
		_, err := os.Stat(tempFolder + "/backend.tf")
		assert.Equal(t, nil, err)
		// Delete the backend.tf file (In the test pipeline we won't bother with migrating the state. We trust that Hashicorp already tests that functionality in their own tests)
		err = os.Remove(tempFolder + "/backend.tf")
		assert.Equal(t, nil, err)
	})

	// Run assertions
	teststructure.RunTestStage(t, "TEST", func() {
		s3BucketID := terraform.Output(t, terraformOptions, "tfstate_bucket_id")
		expectedBucketIDStartsWith := "uds-ex"
		assert.Equal(t, true, strings.HasPrefix(s3BucketID, expectedBucketIDStartsWith))

		dynamoDbTableName := terraform.Output(t, terraformOptions, "tfstate_dynamodb_table_name")
		expectedDynamoDbTableNameStartsWith := "uds-ex"
		assert.Equal(t, true, strings.HasPrefix(dynamoDbTableName, expectedDynamoDbTableNameStartsWith))
	})
}
