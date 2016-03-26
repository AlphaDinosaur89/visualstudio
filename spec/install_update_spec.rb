# encoding: UTF-8
describe 'visualstudio::install_update' do
  describe 'Visual Studio 2015 Community Edition' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
      end.converge(described_recipe)
    end
    it 'does not install any updates by default' do
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2015_update')
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2013_update')
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2012_update')
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2010_update')
    end
  end

  describe 'Visual Studio 2012 Ultimate Edition' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
        node.set['visualstudio']['version'] = '2012'
        node.set['visualstudio']['edition'] = 'ultimate'
      end.converge(described_recipe)
    end
    it 'installs the VS 2012 update' do
      expect(chef_run).to install_visualstudio_update('visualstudio_2012_update')
        .with(
          install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 11.0',
          source: 'http://localhost:8080/VS2012.5.iso',
          package_name: 'Visual Studio 2012 Update 5 (KB2707250)',
          checksum: '405bad3d4249dd94b4fa309bb482ade9ce63d968b59cac9e2d63b0a24577285e')
    end
  end
end
