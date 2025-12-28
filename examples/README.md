# Examples

| Python                         | Ruby                                                                       | Implemented | Notes                                   | 
|--------------------------------|----------------------------------------------------------------------------|-------------|-----------------------------------------|
| `import x`                     | [`import 'x'`](./import_x.rb)                                              | ✅          | Same as `require 'x'`                   |
| `import x as y`                | [`import 'x', as: 'Y'`](./import_x_as_y.rb)                                | ⚠️          | Requires only part of the box's context |
| `import x, y, z`               | [`import 'x, y, z'`](./import_x_y_z.rb)                                    | ⚠️          | Same as `%w[x y z].each { require it }` |
| `from x import y`              | [`from 'x', import: 'Y'`](./from_x_import_y.rb)                            | ⚠️          |                                         |
| `from x import y as z`         | [`from 'x', import: 'Y', as: 'Z'`](./from_x_import_y_as_z.rb)              | ⚠️          |                                         |
| `from x import a, b`           | [`from 'x', import: %w[A, B]`](./from_x_import_a_b.rb)                     | ⚠️          |                                         |
| `from x import a as p, b as q` | [`from 'x', import: { A: 'P', B: 'Q' }`](./from_x_import_a_as_p_b_as_q.rb) | ⚠️          |                                         |
| `from x import *`              | [`from 'x', import: '*'`](./from_x_import_star.rb)                         | ⚠️          |                                         |
| `from x.y.z import a`          | [`from 'x/y/z', import: 'A'`](./from_x_y_z_import_a.rb)                    | ⚠️          |                                         |
| `from x.y.z import a as b`     | [`from 'x/y/z', import: 'A', as: 'B'`](./from_x_y_z_import_a_as_b.rb)      | ⚠️          |                                         |
| `N/A`                          | [`import 'x', as: 'Y' do .. end`](./import_x_as_y_scoped.rb)               | ⚠️          |                                         |
