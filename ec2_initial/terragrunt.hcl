include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "ec2_initial_sg" {
  config_path = "../security_groups/ec2_initial_sg"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    sg_name_ec2_innitial = "fake-sg-name"
  }
}

inputs = {
  sg_name_ec2_innitial = dependency.ec2_initial_sg.outputs.ec2_innitial
  connection_ssh1 = "../datafiles/jumpbox_ppal_ssh.pem"

}

