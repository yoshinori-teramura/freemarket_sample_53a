# NOTE:gem 'ancestry'をインストールする必要があります

def set_category(root, children, grandchildren)
  root_c = Category.create(name: root)

  children.each_with_index do |child, i|
    children_c = root_c.children.create(name: child)
    grandchildren[i].each do |grandchild|
      children_c.children.create(name: grandchild)
    end
  end
end

lady_children = ['トップス', 'ジャケット/アウター', 'パンツ']
lady_grandchildren = [['Tシャツ', 'ポロシャツ', 'タンクトップ'],
                   ['テーラードジャケット', 'ポンチョ', 'トレンチコート'],
                   ['デニム', 'ジーンズ', 'ショートパンツ']]
set_category('レディース', lady_children, lady_grandchildren)

man_children = ['トップス', 'ジャケット/アウター', 'パンツ']
man_grandchildren = [['Tシャツ', 'ポロシャツ', 'タンクトップ'],
                   ['テーラードジャケット', 'ピーコート', 'モッズコード'],
                   ['デニム', 'ジーンズ', 'ショートパンツ']]
set_category('メンズ', man_children, man_grandchildren)

kid_children = ['キッズ靴', 'おもちゃ', '行事/記念品']
kid_grandhildren = [['スニーカー', 'サンダル', 'ブーツ'],
                  ['ガラガラ','オルゴール', 'ジャングルジム'],
                  ['お宮参り品', 'アルバム', '手形/足形']]
set_category('ベビー・キッズ', kid_children, kid_grandhildren)

Brand.create(name: 'シャネル')
Brand.create(name: 'ナイキ')
Brand.create(name: 'ルイ ヴィトン')