#
# Copyright (C) 2014-2017 Jian Chang <aa65535@live.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocksR-libev
PKG_VERSION:=3.0.7
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/breakwa11/shadowsocks-libev.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)
PKG_SOURCE_VERSION:=f713aa981169d35ff9483b295d1209c35117d70c
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jian Chang <aa65535@live.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocksR-libev/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/breakwa11/shadowsocks-libev
	DEPENDS:=+libopenssl +libpthread +libpcre +zlib
endef

Package/shadowsocksR-libev = $(Package/shadowsocksR-libev/Default)
Package/shadowsocksR-libev-server = $(Package/shadowsocksR-libev/Default)

define Package/shadowsocksR-libev/description
Shadowsocks-libev is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

Package/shadowsocksR-libev-server/description = $(Package/shadowsocksR-libev/description)

CONFIGURE_ARGS += --disable-ssp --disable-documentation --disable-assert

define Package/shadowsocksR-libev/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{local,redir} $(1)/usr/bin
endef

define Package/shadowsocksR-libev-server/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{local,redir} $(1)/usr/bin
endef

$(eval $(call BuildPackage,shadowsocksR-libev))
$(eval $(call BuildPackage,shadowsocksR-libev-server))
