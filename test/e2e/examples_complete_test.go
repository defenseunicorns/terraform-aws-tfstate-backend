package test_test

import (
	"os"
	"path"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformDir := "../../examples/complete"

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Upgrade:      true,
		VarFiles:     []string{"example.tfvars"},
	}

	// Enable -migrate-state and -force-copy with the MigrateState field for terraform init command
	terraformStateOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Upgrade:      true,
		VarFiles:     []string{"example.tfvars"},
		MigrateState: true,
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Run 'terrafrom init -migrate-state -force-copy'
	terraform.Init(t, terraformStateOptions)

	s3BucketID := terraform.Output(t, terraformOptions, "tfstate_bucket_id")
	expectedBucketIDStartsWith := "uds-ex"
	assert.Equal(t, true, strings.HasPrefix(s3BucketID, expectedBucketIDStartsWith))

	dynamoDbTableName := terraform.Output(t, terraformOptions, "tfstate_dynamodb_table_name")
	expectedDynamoDbTableNameStartsWith := "uds-ex"
	assert.Equal(t, true, strings.HasPrefix(dynamoDbTableName, expectedDynamoDbTableNameStartsWith))

	tfStateFile := path.Join(terraformDir, "terraform.tfstate")

	// Remove .terraform dir and terraform state files
	if err := os.RemoveAll(path.Join(terraformDir, ".terraform")); err != nil {
		t.Error(err)
	}
	if err := os.Remove(tfStateFile); err != nil {
		t.Error(err)
	}
	if err := os.Remove(path.Join(terraformDir, "terraform.tfstate.backup")); err != nil {
		t.Error(err)
	}

	terraform.Init(t, terraformOptions)

	terraform.RunTerraformCommand(t, terraformOptions, "state", "pull", ">", tfStateFile)

	if err := os.Remove(path.Join(terraformDir, "backend.tf")); err != nil {
		t.Error(err)
	}

	// Run 'terrafrom init -migrate-state -force-copy'
	terraform.Init(t, terraformStateOptions)
}
