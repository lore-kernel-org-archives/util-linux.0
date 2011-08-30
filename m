Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24068 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab1H3JyR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Aug 2011 05:54:17 -0400
Date: Tue, 30 Aug 2011 11:54:12 +0200
From: Karel Zak <kzak@redhat.com>
To: maximilian attems <max@stro.at>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] raw: fix shadowing of minor function
Message-ID: <20110830095412.GQ1855@nb.net.home>
References: <1314637175-30646-1-git-send-email-max@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1314637175-30646-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 29, 2011 at 06:59:35PM +0200, maximilian attems wrote:
> Noticed while compiling against klibc:
> raw.c: In function ‘query’:
> raw.c:219:16: error: called object ‘minor’ is not a function
> 
> Rename variable from minor to minor_raw.

raw.c: In function ‘query’:
raw.c:241:16: error: ‘minor’ undeclared (first use in this function)

Fixed, applied, thanks.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
