Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbbFHKWG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Jun 2015 06:22:06 -0400
Date: Mon, 8 Jun 2015 12:22:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Guillem Jover <guillem@hadrons.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sulogin: Use read instead of allocated size from
 getline()
Message-ID: <20150608102204.GD1992@ws.net.home>
References: <1433564803-9702-1-git-send-email-guillem@hadrons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433564803-9702-1-git-send-email-guillem@hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 06, 2015 at 06:26:43AM +0200, Guillem Jover wrote:
>  login-utils/sulogin-consoles.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

 Applied, thanks.
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
