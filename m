Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54219 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbbAGJiJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Jan 2015 04:38:09 -0500
Date: Wed, 7 Jan 2015 10:38:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Patrick Hemmer <kernel@feystorm.net>
Cc: util-linux@vger.kernel.org
Subject: Re: statically linked nsenter
Message-ID: <20150107093804.GE15715@x2.net.home>
References: <54AB110A.90604@feystorm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54AB110A.90604@feystorm.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 05, 2015 at 05:32:42PM -0500, Patrick Hemmer wrote:
> This is just a simple request for the configure script to support
> statically linking the nsenter utility.
> Several other utilities are supported, but not nsenter, which I would
> argue is probably the most important tool to support static linking as
> it can be used to work with namespaces where the libraries it needs are
> not be available.

OK, trivial change, implemented

 ./configure --enable-static-programs
 make nsenter.static

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
