require 'spec_helper'

describe "DomainRules" do

	before do
		@domain_rule = DomainRule.new(url: "http://espn.go.com")
	end

	subject { @domain_rule }

	describe "when url already is in database" do
		before do
			duplicate = @domain_rule.dup
			duplicate.url = duplicate.url.upcase
			duplicate.save
		end

		it { should_not be_valid }
	end

	describe "when url is empty" do
		before do
			@domain_rule.url = ""
			@domain_rule.save
		end

		it { should_not be_valid}
	end

end

