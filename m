Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52190 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbaILJuv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Sep 2014 05:50:51 -0400
Date: Fri, 12 Sep 2014 11:50:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 17/17] setarch: remove unreachable code
Message-ID: <20140912095038.GW21325@x2.net.home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
 <1410093785-17537-18-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410093785-17537-18-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 07, 2014 at 01:43:05PM +0100, Sami Kerola wrote:
> Architectures are protected using '#if defined' clauses, making the code
> in this removal to be impossible to reach.

 Hmmm.. I guess the code tries to verify that the result architecture
 after personality() matches with uname.machine (except to
 i{486,586,...}), to be sure that our request has been correctly
 interpreted by kernel.

 IMHO it's correct.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
