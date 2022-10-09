defmodule Nicefitserver.Estimator.Positions.KNNEstimator do
  def compute(input, dataset, k \\ 3) do
    sort(input, dataset)
    |> Enum.take(k)
  end

  def getTop(dataset) do
    Enum.group_by(dataset, &elem(&1, 2))
    |> Enum.max_by(&length(elem(&1, 1)))
    |> elem(0)
  end

  def sort(input, dataset) do
    Enum.sort_by(dataset, &Distancia.Euclidean.calculate(&1, input))
  end

  @spec train(any, integer) :: any
  def train(data, _epochs) do
    data
  end

  def calc(h, w, a, data) do
    subjects =
      Enum.map(data, fn e ->
        Kernel.elem(e, 0)
      end)

    member = compute({h, w, a}, subjects)
    m = Enum.at(member, 0)

    real_member =
      Enum.filter(data, fn e ->
        i = Kernel.elem(e, 0)
        rh = Kernel.elem(i, 0)
        rw = Kernel.elem(i, 1)
        ra = Kernel.elem(i, 2)
        mh = Kernel.elem(m, 0)
        mw = Kernel.elem(m, 1)
        ma = Kernel.elem(m, 2)
        rh == mh && rw == mw && ra == ma
      end)

    Kernel.elem(Enum.at(real_member, 0), 1)
  end
end
