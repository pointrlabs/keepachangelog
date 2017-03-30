require 'spec_helper'

module Keepachangelog
  describe MarkdownPrinter do
    describe '.to_s' do
      it 'should print markdown document' do
        versions = {
          '1.0.0' => {
            'changes' => { 'New' => ['Feature A'] }
          }
        }
        p = MarkdownPrinter.new(versions, title: 'My Title')
        md = p.to_s
        expect(md).to match('# My Title')
        expect(md).to match('## 1.0.0')
      end

      it 'should order versions numerically' do
        versions = {
          '0.1.0' => {
            'changes' => { 'New' => ['Feature A'] }
          },
          '0.10.0' => {
            'changes' => { 'New' => ['Feature B'] }
          },
          '0.2.0' => {
            'changes' => { 'New' => ['Feature C'] }
          }
        }
        p = MarkdownPrinter.new(versions)
        md = p.to_s.delete("\n")
        expect(md).to match(/.*0\.10\.0.*0\.2\.0.*0\.1\.0.*/)
      end
    end
  end
end