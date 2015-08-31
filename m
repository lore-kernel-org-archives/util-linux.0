Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbbHaILf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Aug 2015 04:11:35 -0400
Date: Mon, 31 Aug 2015 10:11:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/strutil: fix parse_switch resource leak
 [coverity scan]
Message-ID: <20150831081132.GA2726@ws.net.home>
References: <1440520061-23922-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440520061-23922-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 25, 2015 at 06:27:40PM +0200, Andreas Henriksson wrote:
>  lib/strutils.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

 Applied (both patches), thanks.
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
