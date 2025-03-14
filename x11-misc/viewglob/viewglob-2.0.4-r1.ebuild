# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools readme.gentoo-r1

DESCRIPTION="Graphical display of directories and globs referenced at the shell prompt"
HOMEPAGE="https://viewglob.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/viewglob/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:2
	|| ( app-shells/bash:* app-shells/zsh )"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-underlinking.patch
	"${FILESDIR}"/${P}-format-security.patch
	"${FILESDIR}"/${P}-C23.patch
)

src_prepare() {
	default

	eautoreconf
}

src_install() {
	default

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
