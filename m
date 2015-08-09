Return-Path: util-linux-owner@vger.kernel.org
Received: from zproxy01.unex.es ([158.49.17.42]:60889 "EHLO zproxy01.unex.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933108AbbHIRT0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 9 Aug 2015 13:19:26 -0400
Date: Sun, 9 Aug 2015 19:19:06 +0200
From: Santiago Vila <sanvila@unex.es>
To: Reuti <reuti@staff.uni-marburg.de>
Cc: util-linux@vger.kernel.org, ah-util-linux@debian.org,
        794727@bugs.debian.org
Subject: Re: "mesg n" exits with error, even if the command is successful
Message-ID: <20150809171906.GA27138@cantor.unex.es>
References: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es>
 <7302EB7B-64A1-44E7-B2C2-E28D22FDED7D@staff.uni-marburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7302EB7B-64A1-44E7-B2C2-E28D22FDED7D@staff.uni-marburg.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 09, 2015 at 07:14:30PM +0200, Reuti wrote:
> The profile is usually sourced. How does the error show up at the login prompt on Debian?

The problem only happens in Debian testing and unstable, which I am not using yet.
This is the original report which I received against base-files:

https://bugs.debian.org/794727
