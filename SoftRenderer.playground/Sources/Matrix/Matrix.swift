import Foundation

public struct Matrix<F: FloatingPoint> {
  public var rowCount: Int!
  public var columnCount: Int!
  public var data: [F]!

  public init(rows: Int, columns: Int, filling: F = F.zero) {
    rowCount = rows
    columnCount = columns
    data = [F](repeating: filling, count: rows * columns)
  }

  @inlinable
  public func get(row: Int, column: Int) -> F? {
    if row < 0 || column < 0 || row >= rowCount || column >= columnCount {
      return nil
    }
    return data[row * columnCount + column]
  }

  @inlinable
  mutating public func set(row: Int, column: Int, to target: F) {
    if row < 0 || column < 0 || row >= rowCount || column >= columnCount {
      return
    }
    data[row * columnCount + column] = target
  }

  @inlinable
  mutating public func setRow(row: Int, to target: [F]) {
    if target.count != columnCount {
      fatalError("trying to setRow with unmatched target size")
    }
    for index in 0..<target.count {
      set(row: row, column: index, to: target[index])
    }
  }

  @inlinable
  mutating public func setColumn(column: Int, to target: [F]) {
    if target.count != rowCount {
      fatalError("trying to setColumn with unmatched target size")
    }
    for index in 0..<target.count {
      set(row: index, column: column, to: target[index])
    }
  }

  @inlinable
  public func transpose() -> Matrix<F> {
    var result = Matrix<F>(rows: columnCount, columns: rowCount)
    for row in 0..<rowCount {
      for column in 0..<columnCount {
        result.set(row: column, column: row, to: get(row: row, column: column) ?? .zero)
      }
    }
    return result
  }
}

public func + <F: FloatingPoint>(left: Matrix<F>, right: Matrix<F>) -> Matrix<F> {
  if left.rowCount != right.rowCount || left.columnCount != right.columnCount {
    fatalError("trying to + two matrix with different size")
  }
  var result = Matrix<F>(rows: left.rowCount, columns: right.columnCount)
  for row in 0..<left.rowCount {
    for column in 0..<right.columnCount {
      let left = left.get(row: row, column: column)
      let right = right.get(row: row, column: column)
      if left != nil && right != nil {
        let sum = left! + right!
        result.set(row: row, column: column, to: sum)
      }
    }
  }
  return result
}

public func - <F: FloatingPoint>(left: Matrix<F>, right: Matrix<F>) -> Matrix<F> {
  if left.rowCount != right.rowCount || left.columnCount != right.columnCount {
    fatalError("trying to - two matrix with different size")
  }
  var result = Matrix<F>(rows: left.rowCount, columns: right.columnCount)
  for row in 0..<left.rowCount {
    for column in 0..<right.columnCount {
      let left = left.get(row: row, column: column)
      let right = right.get(row: row, column: column)
      if left != nil && right != nil {
        let diff = left! - right!
        result.set(row: row, column: column, to: diff)
      }
    }
  }
  return result
}

public func * <F: FloatingPoint>(left: Matrix<F>, right: F) -> Matrix<F> {
  var result = Matrix<F>(rows: left.rowCount, columns: left.columnCount)
  for row in 0..<left.rowCount {
    for column in 0..<left.columnCount {
      let value = left.get(row: row, column: column)
      if value != nil {
        result.set(row: row, column: column, to: value! * right)
      }
    }
  }
  return result
}

public func * <F: FloatingPoint>(left: F, right: Matrix<F>) -> Matrix<F> {
  var result = Matrix<F>(rows: right.rowCount, columns: right.columnCount)
  for row in 0..<right.rowCount {
    for column in 0..<right.columnCount {
      let value = right.get(row: row, column: column)
      if value != nil {
        result.set(row: row, column: column, to: value! * left)
      }
    }
  }
  return result
}

public func * <F: FloatingPoint>(left: Matrix<F>, right: Matrix<F>) -> Matrix<F> {
  if left.columnCount != right.rowCount {
    fatalError("trying to * two matrix with unmatched size")
  }
  var result = Matrix<F>(rows: left.rowCount, columns: right.columnCount)
  for resultRow in 0..<left.rowCount {
    for resultColumn in 0..<right.columnCount {
      var sum: F = F.zero
      for interIndex in 0..<left.columnCount {
        sum +=
          (left.get(row: resultRow, column: interIndex) ?? F.zero)
          * (right.get(row: interIndex, column: resultColumn) ?? F.zero)
      }
      result.set(row: resultRow, column: resultColumn, to: sum)
    }
  }
  return result
}

public func == <F: FloatingPoint>(left: Matrix<F>, right: Matrix<F>) -> Bool {
  if left.rowCount != right.rowCount || left.columnCount != right.columnCount {
    return false
  }
  for row in 0..<left.rowCount {
    for column in 0..<right.columnCount {
      let left = left.get(row: row, column: column)
      let right = right.get(row: row, column: column)
      if left != right {
        return false
      }
    }
  }
  return true
}
