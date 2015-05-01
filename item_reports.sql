CREATE TABLE item_reports
     (
              user_id serial references users(id) ON UPDATE CASCADE ON DELETE CASCADE,
              item_id serial references items(id) ON UPDATE CASCADE ON DELETE CASCADE,
              PRIMARY KEY(user_id, item_id)
     );