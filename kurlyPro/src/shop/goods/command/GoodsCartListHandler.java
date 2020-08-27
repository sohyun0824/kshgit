package shop.goods.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.goods.model.GoodsCartListDTO;
import shop.goods.service.GoodsCartListService;
import shop.member.model.MemberDTO;

public class GoodsCartListHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
			GoodsCartListService service = new GoodsCartListService();
			MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
			List<GoodsCartListDTO> list = service.select(member.getM_id());
			request.setAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/goods/goods_cart";
	}

}
