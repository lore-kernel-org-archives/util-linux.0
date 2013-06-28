Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30285 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab3F1Nhe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 28 Jun 2013 09:37:34 -0400
Date: Fri, 28 Jun 2013 15:37:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Marek Mrva <mrvamarek@yahoo.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [bug] Cannot mount from directories containing = (equals)
Message-ID: <20130628133732.GA13089@x2.net.home>
References: <1372412934.77779.YahooMailNeo@web162205.mail.bf1.yahoo.com>
 <1372413058.87399.YahooMailNeo@web162204.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372413058.87399.YahooMailNeo@web162204.mail.bf1.yahoo.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 28, 2013 at 02:50:58AM -0700, Marek Mrva wrote:
> This problem probably occurs because the = character forces the
> mount command to interpret the path as an UUID rather than a file
> 
> Some info:
> 
> # mount -V mount from util-linux 2.22.2 (libmount 2.22.0: debug)

This should be already fixed in version 2.23. Note that the mount
source has to be specified by absolute path otherwise it's still
interpreted as a tag.

(It will probably necessary to extend libblkid API and add a new
 function to verify what is a valid tag.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
