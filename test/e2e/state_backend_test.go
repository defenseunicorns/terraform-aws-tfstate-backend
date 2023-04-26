package test_test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestStateBackend(t *testing.T) {
	t.Parallel()
	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		VarFiles:     []string{"example.tfvars"},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Check that the S3 bucket ID is what we expect it to be.
	s3BucketID := terraform.Output(t, terraformOptions, "tfstate_bucket_id")
	expectedBucketIDStartsWith := "uds-ex"
	assert.Equal(t, true, strings.HasPrefix(s3BucketID, expectedBucketIDStartsWith), fmt.Sprintf("Expected the S3 bucket ID to start with: '%s', but got: '%s'", expectedBucketIDStartsWith, s3BucketID))

	// Check that the DynamoDB table name is what we expect it to be.
	dynamoDbTableName := terraform.Output(t, terraformOptions, "tfstate_dynamodb_table_name")
	expectedDynamoDbTableNameStartsWith := "uds-ex-lock"
	assert.Equal(t, true, strings.HasPrefix(dynamoDbTableName, expectedDynamoDbTableNameStartsWith), fmt.Sprintf("Expected the DynamoDB Table name to start with: '%s', but got: '%s'", expectedDynamoDbTableNameStartsWith, dynamoDbTableName))
}
