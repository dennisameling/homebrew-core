require "language/node"

class ApolloCli < Formula
  desc "Command-line tool for Apollo GraphQL"
  homepage "https://apollographql.com"
  url "https://registry.npmjs.org/apollo/-/apollo-2.32.5.tgz"
  sha256 "f228c76f247c095acbadb848e49764dbe071cd8dbe26c7ed3d29aa5f2685a2f8"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f434c8484763c0a4d6bf7a07388479066e7c7a7ccb4393625a8e98d12fc213a1"
    sha256 cellar: :any_skip_relocation, big_sur:       "1fc3c00f4a19c5d6d14ce4d0d1d13359af23b7ffca125aa6bb8cf60add7ed681"
    sha256 cellar: :any_skip_relocation, catalina:      "e03caea9f82ef5c0c26ae30764cd11892624aadc24ad18550b1a9e857d4ad187"
    sha256 cellar: :any_skip_relocation, mojave:        "c39c0db1b4c63c3822926d584557f80217349ae55f85068530aac9f964a7dc69"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "apollo/#{version}", shell_output("#{bin}/apollo --version")

    assert_match "Missing required flag:", shell_output("#{bin}/apollo codegen:generate 2>&1", 2)

    error_output = shell_output("#{bin}/apollo codegen:generate --target typescript 2>&1", 2)
    assert_match "Error: No schema provider was created", error_output
  end
end
