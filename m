Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55986 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbbALKRd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Jan 2015 05:17:33 -0500
Date: Mon, 12 Jan 2015 11:17:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: sync the docstring of addpart, delpart and
 resizepart to the man page
Message-ID: <20150112101729.GC20899@x2.net.home>
References: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 11, 2015 at 10:27:55PM +0100, Benno Schulenberg wrote:
>  disk-utils/addpart.8    |   19 ++++++++++---------
>  disk-utils/delpart.8    |   18 ++++++------------
>  disk-utils/resizepart.8 |   17 +++++++++--------
>  3 files changed, 25 insertions(+), 29 deletions(-)

 All 4 patches applied. Thanks.

> -This command doesn't manipulate partitions on the hard drive.
> +This command doesn't manipulate partitions on a hard drive.

 This is not too precise, "hard drive" seems like a legacy. All the
 utils (including fdisks) works with "block devices". It's not 
 strictly about hard drives. Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
