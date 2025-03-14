# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp toolchain-funcs

DESCRIPTION="The Emacs Multimedia System"
HOMEPAGE="https://www.gnu.org/software/emms/
	https://www.emacswiki.org/emacs/EMMS"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://git.savannah.gnu.org/git/emms.git"
else
	SRC_URI="https://git.savannah.gnu.org/cgit/emms.git/snapshot/${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~sparc ~x86"
fi

LICENSE="GPL-3+ FDL-1.1+"
SLOT="0"

RDEPEND="media-libs/taglib:="
DEPEND="${RDEPEND}"

# EMMS can use almost anything for playing media files therefore the dependency
# possibilities are so broad that we refrain from setting anything explicitly
# in DEPEND/RDEPEND.

DOCS=( AUTHORS NEWS README )
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" all emms-print-metadata
}

src_install() {
	elisp-install "${PN}" *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	exeinto /usr/bin
	doexe src/emms-print-metadata

	doinfo doc/emms.info*
	doman emms-print-metadata.1

	einstalldocs
}
