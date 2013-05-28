Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35639 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933785Ab3E1NuN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 May 2013 09:50:13 -0400
Date: Tue, 28 May 2013 15:50:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0000] pull: cal the branch four
Message-ID: <20130528135000.GD30341@x2.net.home>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 26, 2013 at 10:14:06AM +0100, Sami Kerola wrote:
>  misc-utils/Makemodule.am   |   2 +-
>  misc-utils/cal.1           |  16 +-
>  misc-utils/cal.c           | 611 +++++++++++++++++++++++----------------------
>  tests/expected/cal/1m      |  48 ++--
>  tests/expected/cal/3m      |  48 ++--
>  tests/expected/cal/bigyear | 206 +++++++++++++++
>  tests/expected/cal/color   |  55 ++++
>  tests/expected/cal/sep1752 | 198 +++++++++++++++
>  tests/expected/cal/year    | 240 +++++++++---------
>  tests/ts/cal/bigyear       |  95 +++++++
>  tests/ts/cal/color         |  68 +++++
>  tests/ts/cal/sep1752       |  95 +++++++
>  12 files changed, 1211 insertions(+), 471 deletions(-)
>  create mode 100644 tests/expected/cal/bigyear
>  create mode 100644 tests/expected/cal/color
>  create mode 100644 tests/expected/cal/sep1752
>  create mode 100755 tests/ts/cal/bigyear
>  create mode 100755 tests/ts/cal/color
>  create mode 100755 tests/ts/cal/sep1752

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
