package test_test

import (
	"os"
	"testing"
)

// TestMain is the entry point for all tests.
func TestMain(m *testing.M) {
	exitVal := m.Run()
	os.Exit(exitVal)
}
