package test_test

import (
	"github.com/stretchr/testify/assert"
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
		Upgrade:      false,
		VarFiles:     []string{"example.tfvars"},
		Vars: map[string]interface{}{
			// Creating the backend.tf file would create issues with the test pipeline, since Terraform will throw an error saying "Backend initialization required, please run "terraform init". To avoid that, we'll skip the creation of the backend.tf file.
			"create_backend_file": false,
		},
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
