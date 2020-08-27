package shop.goods.service;

import java.sql.Connection;
import java.util.List;

import com.util.ConnectionProvider;

import shop.goods.dao.GoodsCartDAO;
import shop.goods.model.GoodsCartListDTO;

public class GoodsCartListService {

	public List<GoodsCartListDTO> select(String m_id) {
		GoodsCartDAO dao = GoodsCartDAO.getInstance();
		try(Connection conn = ConnectionProvider.getConnection()) {
			List<GoodsCartListDTO> list = dao.selectList(conn, m_id);
			return list;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}
