Return-Path: elseifthen@gmx.com
Subject: [v5 PATCH 0/3] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1d114341-0c88-3d25-977a-0000320d1d98@gmx.com>
Date: Tue, 16 Jan 2018 16:37:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 7bd0c1ae18b1c9864b55c0362b737383e70f80c3:

  include/debug: improve debug message (2018-01-12 13:46:49 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 180115

for you to fetch changes up to a4b55ad0080d1024808a7e27a740c63bbef3464f:

  cal: update man page (2018-01-16 13:51:43 -0500)

----------------------------------------------------------------
J William Piggott (3):
      cal: move REFORMATION_YEAR to control struct
      cal: add option to set Gregorian reform date
      cal: update man page

 misc-utils/cal.1 |  83 +++++++++++++++++++++++++++++----
 misc-utils/cal.c | 137 +++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 171 insertions(+), 49 deletions(-)
