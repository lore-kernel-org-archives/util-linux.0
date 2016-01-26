Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58680 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932284AbcAZKPw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jan 2016 05:15:52 -0500
Date: Tue, 26 Jan 2016 11:15:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        David =?utf-8?B?xaB0xJtyYmE=?= <dsterba@suse.cz>
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160126101550.jztna4mi4eaapees@ws.net.home>
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
 <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A15487.8020500@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 21, 2016 at 10:58:31PM +0100, Stanislav Brabec wrote:
>  libmount/src/Makemodule.am |   2 +
>  libmount/src/btrfs.c       | 102 +++++++++++++++++++++++++++++++++++++
>  libmount/src/btrfs.h       | 122 +++++++++++++++++++++++++++++++++++++++++++++
>  libmount/src/libmount.h.in |   2 +
>  libmount/src/mountP.h      |   6 +++
>  libmount/src/tab.c         |  83 ++++++++++++++++++++++++++++--
>  6 files changed, 313 insertions(+), 4 deletions(-)
>  create mode 100644 libmount/src/btrfs.c
>  create mode 100644 libmount/src/btrfs.h

 Merged with some minor changes. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
