Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:57300 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3ATSFC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 13:05:02 -0500
Received: by mail-wi0-f179.google.com with SMTP id o1so4335483wic.6
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 10:05:00 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/6] pull: nsenter: trivial adjustments
Date: Sun, 20 Jan 2013 18:04:50 +0000
Message-Id: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

'Allo 'allo!

Recently nsenter was added to the project.  I had a look of it which
resulted to six rather trivial patches, that are sent to list and
available from my git branch mentioned below.


The following changes since commit e66ba1bfaf070682e26c1a53e64af1088fea56bc:

  cal: don't mix ncurses output functions and printf() (2013-01-17 18:48:16 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git nsenter

for you to fetch changes up to 8602caa37ac3fdc0edbcafc15c98f9c3483e552a:

  nsenter: fix indentation (2013-01-19 20:18:52 +0000)

----------------------------------------------------------------
Sami Kerola (6):
      docs: align nsenter.1 man page with howto-man-page.txt
      build-sys: add nsenter to gitignore
      nsenter: adjust few error messages
      nsenter: fix compiler warning
      nsenter: drop core when impossible happens
      nsenter: fix indentation

 .gitignore          |   1 +
 include/namespace.h |  55 +++++++-------
 sys-utils/nsenter.1 | 201 ++++++++++++++++++++++++++++++++--------------------
 sys-utils/nsenter.c |  42 ++++++-----
 4 files changed, 179 insertions(+), 120 deletions(-)

