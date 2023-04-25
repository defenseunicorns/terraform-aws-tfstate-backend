package test_test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"strings"
	"testing"
)

func TestExamplesComplete(t *testing.T) {
	t.Parallel()
	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		VarFiles:     []string{"example.tfvars"},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	s3BucketID := terraform.Output(t, terraformOptions, "tfstate_bucket_id")
	expectedBucketIDStartsWith := "uds-ex"
	assert.Equal(t, true, strings.HasPrefix(s3BucketID, expectedBucketIDStartsWith))

	dynamoDbTableName := terraform.Output(t, terraformOptions, "tfstate_dynamodb_table_name")
	expectedDynamoDbTableNameStartsWith := "uds-ex-lock"
	assert.Equal(t, true, strings.HasPrefix(dynamoDbTableName, expectedDynamoDbTableNameStartsWith))
}
