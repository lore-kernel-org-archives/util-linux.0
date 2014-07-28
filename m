Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbaG1JRl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 05:17:41 -0400
Date: Mon, 28 Jul 2014 11:17:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: fix some things that were overlooked during
 the first pass
Message-ID: <20140728091737.GF8533@x2.net.home>
References: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 25, 2014 at 02:55:01PM +0200, Benno Schulenberg wrote:
>  sys-utils/dmesg.1     |   29 ++++++++------
>  sys-utils/eject.1     |   94 +++++++++++++++++++++++++++-----------------
>  sys-utils/fallocate.1 |  104 ++++++++++++++++++++++++++----------------------
>  sys-utils/flock.1     |   61 ++++++++++++++--------------
>  sys-utils/ipcmk.1     |   10 ++--
>  sys-utils/ipcrm.1     |   48 +++++++++++++----------
>  sys-utils/renice.1    |    6 +-
>  sys-utils/setpriv.1   |  102 ++++++++++++++++++++++++------------------------
>  sys-utils/setsid.1    |    9 ++++-
>  sys-utils/unshare.1   |    9 +++-
>  10 files changed, 260 insertions(+), 212 deletions(-)

 Applied all patches in the set. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
