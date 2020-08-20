include $(TOPDIR)/rules.mk

PKG_NAME:=cloudflared
PKG_VERSION:=2020.8.0
PKG_RELEASE:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cloudflare/cloudflared
PKG_SOURCE_VERSION:=2020.8.0

PKG_LICENSE:=CloudFlare
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=BH4EHN <edyuy@zmyseries.com>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/cloudflare/cloudflared/cmd/cloudflared
GO_PKG_LDFLAGS:=-s -w
# PKG_CONFIG_DEPENDS:= 

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/$(PKG_NAME)
  TITLE:=Argo Tunnel client
  URL:=https://developers.cloudflare.com/argo-tunnel/
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/$(PKG_NAME)/description
	Contains the command-line client and its libraries for Argo Tunnel, a tunneling daemon that proxies any local webserver through the Cloudflare network.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
	# uncomment this line if upx presents
	# $(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/cloudflared
endef

define Package/$(PKG_NAME)/install
	$(CP) ./files/* $(1)/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/cloudflared $(1)/usr/bin/cloudflared
endef
$(eval $(call GoBinPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))