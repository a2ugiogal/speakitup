package com.web.speakitup._00_init;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.LinkedHashSet;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.ArticleCategoryBean;
import com.web.speakitup.model.CategoryBean;
import com.web.speakitup.model.CommentBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.model.OrderBean;
import com.web.speakitup.model.OrderItemBean;
import com.web.speakitup.model.ProductBean;
import com.web.speakitup.model.ProductFormatBean;

/* 未完成: data未製作完成(only 測試版) */
/* member: likeArticles、authToken、checkAuthSuccess設定? */
//					這個預設我是給會員email加密          這個我給y(代表認證成功)    

public class EDMTableResetHibernate {
	public static final String UTF8_BOM = "\uFEFF"; // 定義 UTF-8的BOM字元

	public static void main(String args[]) {
		String line = "";

		SessionFactory factory = HibernateUtils.getSessionFactory();

		// 商品類(product)一起新增
		Session session = factory.getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();

			// 1. ProductCategory
			try (FileReader fr1 = new FileReader("data/product/productCategory.dat");
					BufferedReader br1 = new BufferedReader(fr1);) {
				while ((line = br1.readLine()) != null) {
					if (line.startsWith(UTF8_BOM)) {
						line = line.substring(1);
					}
					String[] token1 = line.split("\\|");
					String categoryTitle1 = token1[0];
					String categoryName1 = token1[1];
					String[] categoryProducts = token1[2].split(",");
					CategoryBean categoryBean = new CategoryBean(null, categoryTitle1, categoryName1, null);

					// 2. Products
					Set<ProductBean> products = new LinkedHashSet<>();
					try (FileReader fr2 = new FileReader("data/product/products.dat");
							BufferedReader br2 = new BufferedReader(fr2);) {
						while ((line = br2.readLine()) != null) {
							if (line.startsWith(UTF8_BOM)) {
								line = line.substring(1);
							}
							String[] token2 = line.split("\\|");
							String productName = token2[0];
							for (String str : categoryProducts) {
								if (str.equals(productName)) {
									CategoryBean cb = categoryBean;
									Integer price = Integer.parseInt(token2[1].trim());
									String fileName = GlobalService.extractFileName(token2[2].trim());
									Blob image = GlobalService.fileToBlob(token2[2].trim());
									Clob detail = GlobalService.fileToClob(token2[3]);
									Integer sales = Integer.parseInt(token2[4].trim());

									ProductBean product = new ProductBean(null, productName, cb, price, fileName, image,
											detail, sales, null);

									// 3. ProductFormat
									Set<ProductFormatBean> productFormats = new LinkedHashSet<>();
									try (FileReader fr3 = new FileReader("data/product/productFormat.dat");
											BufferedReader br3 = new BufferedReader(fr3);) {
										while ((line = br3.readLine()) != null) {
											if (line.startsWith(UTF8_BOM)) {
												line = line.substring(1);
											}
											String[] token = line.split("\\|");
											String productNameCheck = token[5];
											if (productName.equals(productNameCheck)) {
												String formatTitle1 = token[0];
												String formatContent1 = token[1];
												String formatTitle2 = token[2];
												String formatContent2 = token[3];
												Integer stock = Integer.parseInt(token[4].trim());

												ProductFormatBean productFormat = new ProductFormatBean(null,
														formatTitle1, formatContent1, formatTitle2, formatContent2,
														stock, product);
												productFormats.add(productFormat);
											}
										}
									} catch (Exception e) {
										e.printStackTrace();
										if (tx != null) {
											tx.rollback();
										}
										System.err.println("新建ProductFormat表格時發生例外: " + e.getMessage());
									}
									product.setProductFormat(productFormats);
									products.add(product);
								}
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
						if (tx != null) {
							tx.rollback();
						}
						System.err.println("新建Products表格時發生例外: " + e.getMessage());
					}
					categoryBean.setProducts(products);
					session.save(categoryBean);
					session.flush();
					System.out.println("ProductCategory表格新增成功");
				}
				tx.commit();
			} catch (IOException e) {
				if (tx != null) {
					tx.rollback();
				}
				System.err.println("新建ProductCategory表格時發生IO例外: " + e.getMessage());
			}
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}
		}

		// 訂單類(order)一起新增
		session = factory.getCurrentSession();
		tx = null;
		try {
			tx = session.beginTransaction();

			// 1. Orders
			try (FileReader fr1 = new FileReader("data/order/orders.dat");
					BufferedReader br1 = new BufferedReader(fr1);) {
				while ((line = br1.readLine()) != null) {
					if (line.startsWith(UTF8_BOM)) {
						line = line.substring(1);
					}
					String[] token1 = line.split("\\|");
					Integer memberId = Integer.parseInt(token1[0]);
					String memberName = token1[1];
					Integer totalPrice = 0;
					String address = token1[2];
					String phoneNumber = token1[3];
					String orderNote = token1[4];
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
					Date orderDate = null;
					if (!token1[5].equals("")) {
						orderDate = new Date(simpleDateFormat.parse(token1[5].trim()).getTime());
					}
					Date shippingDate = null;
					if (!token1[6].equals("")) {
						shippingDate = new Date(simpleDateFormat.parse(token1[6].trim()).getTime());
					}
					Date arriveDate = null;
					if (!token1[7].equals("")) {
						arriveDate = new Date(simpleDateFormat.parse(token1[7].trim()).getTime());
					}
					String status = token1[8];
					OrderBean orderBean = new OrderBean(null, memberId, memberName, totalPrice, address, phoneNumber,
							orderNote, orderDate, shippingDate, arriveDate, status, null);

					// 2. OrderItems
					Set<OrderItemBean> orderItems = new LinkedHashSet<>();
					OrderItemBean orderItemBean = null;
					try (FileReader fr2 = new FileReader("data/order/orderItems.dat");
							BufferedReader br2 = new BufferedReader(fr2);) {
						while ((line = br2.readLine()) != null) {
							if (line.startsWith(UTF8_BOM)) {
								line = line.substring(1);
							}
							String[] token2 = line.split("\\|");
							String orderNoCheck = token2[6];
							if (token1[9].equals(orderNoCheck)) {
								Integer productId = Integer.parseInt(token2[0].trim());
								String productName = token2[1];
								String formatContent1 = token2[2];
								String formatContent2 = token2[3];
								Integer unitPrice = Integer.parseInt(token2[4].trim());
								Integer quantity = Integer.parseInt(token2[5].trim());
								totalPrice += unitPrice * quantity;

								orderItemBean = new OrderItemBean(null, productId, productName, formatContent1,
										formatContent2, unitPrice, quantity, orderBean);
								orderItems.add(orderItemBean);
							}
						}
					} catch (Exception e) {
						if (tx != null) {
							tx.rollback();
						}
						System.err.println("新建OrderItems表格時發生IO例外: " + e.getMessage());
						e.printStackTrace();
					}
					orderBean.setTotalPrice(totalPrice);
					orderBean.setOrderItems(orderItems);
					session.save(orderBean);
					session.flush();
					System.out.println("Orders表格新增成功");
				}
				tx.commit();
			} catch (Exception e) {
				if (tx != null) {
					tx.rollback();
				}
				System.err.println("新建Orders表格時發生IO例外: " + e.getMessage());
			}
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}
		}

		// 文章類(article)一起新增
		session = factory.getCurrentSession();
		tx = null;
		try {
			tx = session.beginTransaction();

			// 1. ArticleCategory
			try (FileReader fr1 = new FileReader("data/article/articleCategory.dat");
					BufferedReader br1 = new BufferedReader(fr1);) {
				while ((line = br1.readLine()) != null) {
					if (line.startsWith(UTF8_BOM)) {
						line = line.substring(1);
					}
					String[] token1 = line.split("\\|");
					String categoryTitle = token1[0];
					String categoryName = token1[1];
					ArticleCategoryBean articleCategoryBean = new ArticleCategoryBean(null, categoryTitle, categoryName,
							null);

					// 2. Articles
					Set<ArticleBean> articles = new LinkedHashSet<>();
					try (FileReader fr2 = new FileReader("data/article/articles.dat");
							BufferedReader br2 = new BufferedReader(fr2);) {
						while ((line = br2.readLine()) != null) {
							if (line.startsWith(UTF8_BOM)) {
								line = line.substring(1);
							}
							String[] token2 = line.split("\\|");
							String articleCategoryCkeck = token2[9];
							if (token1[2].equals(articleCategoryCkeck)) {
								String title = token2[1];
								Integer authorId = Integer.parseInt(token2[2].trim());
								String authorName = token2[3];
								Timestamp publishTime = Timestamp.valueOf(token2[4].trim());
								ArticleCategoryBean acb = articleCategoryBean;
								Clob content = GlobalService.fileToClob(token2[5]);
								String fileName = GlobalService.extractFileName(token2[6].trim());
								Blob image = GlobalService.fileToBlob(token2[6].trim());
								Integer likes = Integer.parseInt(token2[7].trim());
								String status = token2[8];

								ArticleBean articleBean = new ArticleBean(null, title, authorId, authorName,
										publishTime, acb, content, fileName, image, likes, status, null);

								// 3. Comments
								Set<CommentBean> comments = new LinkedHashSet<>();
								try (FileReader fr3 = new FileReader("data/article/comments.dat");
										BufferedReader br3 = new BufferedReader(fr3);) {
									while ((line = br3.readLine()) != null) {
										if (line.startsWith(UTF8_BOM)) {
											line = line.substring(1);
										}
										String[] token3 = line.split("\\|");
										String articleIdCheck = token3[5];
										if (token2[0].equals(articleIdCheck)) {
											Integer commentAuthorId = Integer.parseInt(token3[0].trim());
											String commentAuthorName = token3[1];
											Timestamp commentPublishTime = Timestamp.valueOf(token3[2].trim());
											String commentContent = token3[3];
											String commentStatus = token3[4];
											ArticleBean ab = articleBean;

											CommentBean commentBean = new CommentBean(null, commentAuthorId,
													commentAuthorName, commentPublishTime, commentContent, ab,
													commentStatus);
											comments.add(commentBean);
										}
									}
								} catch (Exception e) {
									e.printStackTrace();
									if (tx != null) {
										tx.rollback();
									}
									System.err.println("新建Comments表格時發生例外: " + e.getMessage());
								}
								articleBean.setArticleComments(comments);
								articles.add(articleBean);
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
						if (tx != null) {
							tx.rollback();
						}
						System.err.println("新建Articles表格時發生例外: " + e.getMessage());
					}
					articleCategoryBean.setArticles(articles);
					session.save(articleCategoryBean);
					session.flush();
					System.out.println("ArticleCategory表格新增成功");
				}
				tx.commit();
			} catch (IOException e) {
				if (tx != null) {
					tx.rollback();
				}
				System.err.println("新建ArticleCategory表格時發生IO例外: " + e.getMessage());
			}
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}
		}

		// 會員(member)新增
		session = factory.getCurrentSession();
		tx = null;
		try {
			tx = session.beginTransaction();

			// 1. Members
			try (FileReader fr1 = new FileReader("data/member/members.dat");
					BufferedReader br1 = new BufferedReader(fr1);) {
				while ((line = br1.readLine()) != null) {
					if (line.startsWith(UTF8_BOM)) {
						line = line.substring(1);
					}
					String[] token = line.split("\\|");

					String memberId = token[0];
					String password = token[1];
					password = GlobalService.getMD5Endocing(GlobalService.encryptString(password));
					String gender = token[2];
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
					java.util.Date date = simpleDateFormat.parse(token[3]);
					Date birthday = new Date(date.getTime());
					String email = token[4];
					String phone = token[5];
					String city = token[6];
					String area = token[7];
					String address = token[8];
					String fileName = GlobalService.extractFileName(token[9].trim());
					Blob picture = GlobalService.fileToBlob(token[9].trim());
					Timestamp createTime = Timestamp.valueOf(token[10].trim());
					String status = token[11];
					String permission = token[12];
					String authToken = GlobalService.getMD5Endocing(GlobalService.encryptString(email));
					MemberBean memberBean = new MemberBean(null, memberId, password, gender, birthday, email, phone,
							city, area, address, fileName, picture, createTime, status, permission, null, authToken,
							null, null,null);

					session.save(memberBean);
					session.flush();
					System.out.println("Members表格新增成功");
				}
				tx.commit();
			} catch (IOException e) {
				if (tx != null) {
					tx.rollback();
				}
				System.err.println("新建Members表格時發生IO例外: " + e.getMessage());
			}
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}
		}
		factory.close();
	}
}