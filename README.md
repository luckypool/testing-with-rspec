はじめてのRSpec - まずテスト書いてからコード書くシンプルなチュートリアル
====


![87802.png](https://qiita-image-store.s3.amazonaws.com/0/17133/a09a1ef4-00f1-9db3-41bb-162ee6641387.png "87802.png")

Rubyをあまりさわったことない初心者向けの内容です。

細かいところは置いておいて、とりあえずRSpecでテスト書く→コード実装のような、超シンプルなテスト駆動開発チュートリアルをまとめてみました。

## はじめに

- RSpecはポピュラーなテストフレームワーク
  - https://github.com/rspec/rspec
- DSLとかでフォーマットされてて、自然言語（英語）っぽくテストが書ける
- [David Chelimsky氏](https://github.com/dchelimsky)のブログでもチュートリアルがある（※2007年のエントリ）
  - [an introduction to RSpec - Part I](http://blog.davidchelimsky.net/blog/2007/05/14/an-introduction-to-rspec-part-i/)
- 本なら[The RSpec Book](http://www.amazon.co.jp/dp/4798121932)もあるよ！！4,410円。

## 下準備

### install

```
$ gem install rspec
```

### rspec -- init

```
$ rspec --init
  create   spec/spec_helper.rb
  create   .rspec
```

- [差分](https://github.com/luckypool/testing-with-rspec/commit/873c199a3d22a8d113bb488082ed9e46eea8c718)

## めっちゃシンプルなテスト駆動開発

### (1) テスト対象を決める

- 今回は `/lib/dog.rb` とかを想定する
- まだつくらなくてOK

### (2) テストファイルをつくる

- こんな感じ `spec/lib/dog_spec.rb`
  - \<name_of_spec\>_spec.rb というように `_spec.rb` というsuffixつける

### (3) 最初のテストコード

- [差分](https://github.com/luckypool/testing-with-rspec/commit/c70d81959dcce678d39d9ef43582bd251d0a5244)

```ruby:spec/lib/dog_spec.rb
require "spec_helper"

describe "Dog" do
  it "is name 'Pochi'"
end
```

- 実行結果は・・・

```bash
$ rspec spec/lib/dog_spec.rb
*

Pending:
  Dog is name 'Pochi'
    # Not yet implemented
    # ./spec/lib/dog_spec.rb:4

Finished in 0.00025 seconds
1 example, 0 failures, 1 pending
```

- ペンディングされてるよ！って結果になりました。

### (4)対象モジュールを読み込んだ上でペンディングする

- [差分](https://github.com/luckypool/testing-with-rspec/commit/d323a2e187bb05252f4e69b8397f3d15916b4cda)

```ruby:lib/dog.rb
class Dog

end
```

```ruby:spec/lib/dog_spec.rb
require "spec_helper"
require "dog"

describe Dog do
  it "is name 'Pochi'"
end
```

- 実行結果は・・・

```
$ rspec spec/lib/dog_spec.rb
*

Pending:
  Dog is name 'Pochi'
    # Not yet implemented
    # ./spec/lib/dog_spec.rb:5

Finished in 0.00035 seconds
1 example, 0 failures, 1 pending
```

- まだペンディング中！

### (5)期待通りに落ちるテストを書く

- [差分](https://github.com/luckypool/testing-with-rspec/commit/5a4d879c2595c42a1757e3fd4c99cea658de9ed1)

```ruby:spec/lib/dog_spec.rb
require "spec_helper"
require "dog"

describe Dog do
  it "is name 'Pochi'" do
    dog = Dog.new
    expect(dog.name).to eq 'Pochi'
  end
end
```

- 英語っぽくテストがかけますね！
- 実行結果は・・・

```
$ rspec spec/lib/dog_spec.rb
F

Failures:

  1) Dog is name 'Pochi'
     Failure/Error: expect(dog.name).to eq 'Pochi'
     NoMethodError:
       undefined method `name' for #<Dog:0x007fea60987400>
     # ./spec/lib/dog_spec.rb:7:in `block (2 levels) in <top (required)>'

Finished in 0.00031 seconds
1 example, 1 failure

Failed examples:

rspec ./spec/lib/dog_spec.rb:5 # Dog is name 'Pochi'
```

- ちゃんと落ちました。

### (6)テストが通るように実装する

- [差分](https://github.com/luckypool/testing-with-rspec/commit/f68636c6980b5a1dde060aa6430c3a898dfd1333)

```ruby:lib/dog.rb
class Dog
  attr_accessor :name

  def initialize(name="Pochi")
    @name = name
  end
end
```

- 実行結果はもちろん・・

```
$ rspec spec/lib/dog_spec.rb
.

Finished in 0.00122 seconds
1 example, 0 failures
```

- パスしましたね！ :)

### (7)テスト追加して実装を繰り返す

- こんな感じでテストを追加してきましょう
  - [itじゃなくてxitとやってもpendingになります](https://github.com/luckypool/testing-with-rspec/commit/0fb2968747124c3680ff34c1c9cb48ad2b653c48)
  - [落ちるテストを追加して](https://github.com/luckypool/testing-with-rspec/commit/83c5cc71f8b82e2a11a81a3d63bae64fa1649495)
  - [テストが通るように実装](https://github.com/luckypool/testing-with-rspec/commit/1306817503fdcd7bf8bf7645608218d4b73d7df6)

```ruby:spec/lib/dog_spec.rb
require "spec_helper"
require "dog"

describe Dog do
  it "is named 'Pochi'" do
    dog = Dog.new
    expect(dog.name).to eq 'Pochi'
  end

  it "has fangs" do
    dog = Dog.new
    expect(dog.fangs).to eq 2
  end

  it "is alived" do
    dog = Dog.new
    expect(dog).to be_alived
  end
end
```

```ruby:lib/dog.rb
class Dog
  attr_accessor :name, :horns

  def initialize(name="Pochi")
    @name = name
    @horns = 0
  end

  def alived?
    true
  end
end
```

- グリーン！！

```
$ spec spec/lib/dog_spec.rb
...

Finished in 0.00249 seconds
3 examples, 0 failures
```



## 参考

### Expectations

テストコードは `expect(hogehoge).to be_true` なんて風に書けます。
他にも色々と表現できるのですが、詳しくは下記のREADMEに載っています。

- https://github.com/rspec/rspec-expectations

あと、`should` という expectation もありますが、`expect`の方が新しいものだそうです。

- [RSpecのshouldはもう古い！新しい記法expectを使おう！](http://qiita.com/awakia/items/d880250adc8cdbe7a32f)
- [should and should_not syntax](https://github.com/rspec/rspec-expectations/blob/master/Should.md) に説明があります。
  - *By default, both `expect` and `should` syntaxes are available. In the future, the default may be changed to only enable the `expect` syntax.*
- 新規テストには expect を使いたいですね :)

----

以上！
