Return-Path: mtk.manpages@gmail.com
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Mon, 5 Dec 2016 11:25:45 +0100
Message-ID: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
Subject: Pull request: nsenter(1) fixes
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Karel,

I have various fixes to send, but I'll start small, with a couple of
fixes for nsenter(1). Is a git pull request compatible with your
workflow?

Cheers,

Michael

The following changes since commit e0383e3e88f4d80454bb67b4e8920126c667d258:

  wall: check -g GID (2016-12-02 14:11:20 +0100)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/mtk/util-linux.git doc_fixes

for you to fetch changes up to ff88fc3ba553d14c7b05fb6702e10e1c5c591257:

  docs: nsenter(1): Formatting fix (2016-12-05 11:18:17 +0100)

----------------------------------------------------------------
Michael Kerrisk (2):
      docs: nsenter(1): Describe the 'file' argument used by namespace options
      docs: nsenter(1): Formatting fix

 sys-utils/nsenter.1 | 57 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 14 deletions(-)


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
