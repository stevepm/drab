defmodule Drab.Live.EExEngineTest do
  use ExUnit.Case, ascync: true
  # doctest Drab.Live.EExEngine
  import Drab.Live.EExEngine

  @simple_expr {{:., [line: 7],
                 [
                   {:__aliases__, [line: 7, alias: false], [:Phoenix, :HTML, :Engine]},
                   :fetch_assign
                 ]}, [line: 7],
                [
                  {:var!, [line: 7, context: Drab.Live.EExEngine, import: Kernel],
                   [{:assigns, [line: 7], Drab.Live.EExEngine}]},
                  :link
                ]}

  @nested_expr {:if, [line: 5],
                [
                  {:==, [line: 5],
                   [
                     {{:., [line: 5],
                       [
                         {:__aliases__, [line: 5, alias: false], [:Phoenix, :HTML, :Engine]},
                         :fetch_assign
                       ]}, [line: 5],
                      [
                        {:var!, [line: 5, context: Drab.Live.EExEngine, import: Kernel],
                         [{:assigns, [line: 5], Drab.Live.EExEngine}]},
                        :count
                      ]},
                     42
                   ]},
                  [
                    do:
                      {:safe,
                       [
                         [
                           ["", "\n  <span drab-ampere=\"gm3temrxg4ztcnzz\">\n    inside div: "],
                           "{{{{@drab-expr-hash:gu3tgmzrgq4deoa}}}}",
                           {:case, [generated: true],
                            [
                              {{:., [line: 7],
                                [
                                  {:__aliases__, [line: 7, alias: false], [:Phoenix, :HTML, :Engine]},
                                  :fetch_assign
                                ]}, [line: 7],
                               [
                                 {:var!, [line: 7, context: Drab.Live.EExEngine, import: Kernel],
                                  [{:assigns, [line: 7], Drab.Live.EExEngine}]},
                                 :link
                               ]},
                              [
                                do: [
                                  {:->, [generated: true],
                                   [
                                     [safe: {:data, [generated: true], Drab.Live.EExEngine}],
                                     {:data, [generated: true], Drab.Live.EExEngine}
                                   ]},
                                  {:->, [generated: true],
                                   [
                                     [
                                       {:when, [generated: true],
                                        [
                                          {:bin, [generated: true], Drab.Live.EExEngine},
                                          {:is_binary,
                                           [
                                             generated: true,
                                             context: Drab.Live.EExEngine,
                                             import: Kernel
                                           ], [{:bin, [generated: true], Drab.Live.EExEngine}]}
                                        ]}
                                     ],
                                     {{:., [generated: true],
                                       [
                                         {:__aliases__, [generated: true, alias: false], [:Plug, :HTML]},
                                         :html_escape
                                       ]}, [generated: true], [{:bin, [generated: true], Drab.Live.EExEngine}]}
                                   ]},
                                  {:->, [generated: true],
                                   [
                                     [{:other, [generated: true], Drab.Live.EExEngine}],
                                     {{:., [line: 7],
                                       [
                                         {:__aliases__, [line: 7, alias: false], [:Phoenix, :HTML, :Safe]},
                                         :to_iodata
                                       ]}, [line: 7], [{:other, [line: 7], Drab.Live.EExEngine}]}
                                   ]}
                                ]
                              ]
                            ]},
                           "{{{{/@drab-expr-hash:gu3tgmzrgq4deoa}}}}"
                         ],
                         "\n  </span>\n"
                       ]}
                  ]
                ]}

  test "shallow find assigns in simple expression" do
    assert shallow_find_assigns(@simple_expr) == [:link]
  end

  test "shallow find assigns in nested expression" do
    assert shallow_find_assigns(@nested_expr) == [:count]
  end

  @simple_pattern """
    AAA{{{{@drab-expr-hash:ge2tonjvhe3dqnjv}}}}{{{{/@drab-expr-hash:ge2tonjvhe3dqnjv}}}} X
  """

  @nested_pattern """
  {{{{@drab-expr-hash:gmydcmjshe3dama}}}}{{{{/@drab-expr-hash:gmydcmjshe3dama}}}}
  <b drab-ampere=\"gi2tamrrgy2tcny\">AAA
    {{{{@drab-expr-hash:ge2tonjvhe3dqnjv}}}}{{{{/@drab-expr-hash:ge2tonjvhe3dqnjv}}}}
  </b><b>somethign</b>
  """

  test "assigns from simple pattern" do
    assert assigns_and_parents_from_pattern(@simple_pattern) == {[:color], [:users]}
  end

  test "assigns from netsted pattern" do
    assert assigns_and_parents_from_pattern(@nested_pattern) == {[:link], []}
  end
end
