Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbbAGJwf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Jan 2015 04:52:35 -0500
Date: Wed, 7 Jan 2015 10:52:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: exit 2 when no specified tags match
Message-ID: <20150107095228.GF15715@x2.net.home>
References: <1420150414-7628-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420150414-7628-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 01, 2015 at 11:13:34PM +0100, Andreas Henriksson wrote:
> ,---- [ man blkid ]
> | RETURN CODE
> |        If the specified token was found, or if any tags were shown from (specified) devices, 0 is returned.
> |        If the specified token was not found, or no (specified) devices could be identified, an exit code of 2 is returned.
> |        For usage or other errors, an exit code of 4 is returned.
> |        If the ambivalent low-level probing result was detected, an exit code of 8 is returned.
> `----
> 
> The code doesn't seem to work like described in the (first part of the)
> second sentence. The exit code is only 2 if *no* tokens was identified,
> 0 if tokens was found but none matched the filter.

IMHO it works as expected

 $ blkid -t TYPE=ext4 &> /dev/null; echo $?
 0

 $ blkid -t TYPE=foo &> /dev/null; echo $?
 2

the return code is no affected by output tags, it means by -s <tag>

 $ blkid -t TYPE=ext4 -s DUMMY;  echo $?
 0

 $ blkid -t TYPE=ext4 -s LABEL;  echo $?
 /dev/sda2: LABEL="boot"
 0


maybe we need to improve the man page to make the description more
precise, but code works as expected. It differentiates between device
identification and output stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
