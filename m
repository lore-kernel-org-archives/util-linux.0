Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdEaSpk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 14:45:40 -0400
Subject: [PATCH 0/4] pull request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Date: Wed, 31 May 2017 14:45:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


docs: various changes; see patches for details.

The following changes since commit 3947ca4ca9737d830f54658ef353f5626c0d0282:

  build-sys: ncurses headers cleanup (2017-05-31 11:01:46 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170529

for you to fetch changes up to 80008bcae9a1aed3d38507a319155a69c4414509:

  docs: move source-code-management.txt to README (2017-05-31 11:36:47 -0400)

----------------------------------------------------------------
J William Piggott (4):
      docs: update v2.30-ReleaseNotes
      docs: update howto-contribute.txt
      docs: update howto-contribute.txt
      docs: move source-code-management.txt to README

 Documentation/howto-contribute.txt        | 201 +++++++++++++++---------------
 Documentation/release-schedule.txt        |   2 +-
 Documentation/releases/v2.30-ReleaseNotes |  38 +++---
 Documentation/source-code-management.txt  |  38 ------
 README                                    | 121 +++++++++++++-----
 5 files changed, 215 insertions(+), 185 deletions(-)
 delete mode 100644 Documentation/source-code-management.txt
