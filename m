Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32693 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757027Ab3EGHys (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 May 2013 03:54:48 -0400
Date: Tue, 7 May 2013 09:54:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] Remove invalid compiler warning
Message-ID: <20130507075445.GC29882@x2.net.home>
References: <516E1024.6090101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <516E1024.6090101@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 16, 2013 at 09:59:48PM -0500, Bruce Dubbs wrote:
> I'm not that familiar with git, but this patch is really small.
> Remove an irritating compiler warning in two programs.

It would be better to test the compiler option in ./configure, I have
applied:

 https://github.com/karelzak/util-linux/commit/7697771d8f1df3576c73153f392285bb8973c117

Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
