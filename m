Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbaCZLMQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Mar 2014 07:12:16 -0400
Date: Wed, 26 Mar 2014 12:12:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/5] mcookie: use lib/randutils
Message-ID: <20140326111206.GC23464@x2.net.home>
References: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 08, 2014 at 03:43:26PM -0600, Sami Kerola wrote:
>  include/randutils.h      |  1 +
>  lib/randutils.c          | 19 ++++++++++++++++
>  misc-utils/Makemodule.am |  1 +
>  misc-utils/mcookie.1     | 45 +++++++++++++++-----------------------
>  misc-utils/mcookie.c     | 57 +++++++++---------------------------------------
>  5 files changed, 48 insertions(+), 75 deletions(-)

 All applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
