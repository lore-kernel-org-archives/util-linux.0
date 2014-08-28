Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14914 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932533AbaH1Glb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Aug 2014 02:41:31 -0400
Date: Thu, 28 Aug 2014 08:41:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Rafael Ferreira <rafael.f.f1@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Typo in util-linux 2.25.1-rc1
Message-ID: <20140828064123.GG30359@x2.net.home>
References: <CALLTvwfXQiTM8Y_ZH0C5+xf0C9_VJkKKuDugW4QdejH+gR6ZcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALLTvwfXQiTM8Y_ZH0C5+xf0C9_VJkKKuDugW4QdejH+gR6ZcA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 27, 2014 at 10:38:55PM -0300, Rafael Ferreira wrote:
> While translating, I found the following with a typo:
> 
> file include/optutils.h, line 81, string: "%s: these options
> aremutually exclusive:"

 Thanks! Fixed in master branch (will be in 2.25.2 or/and 2.26).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
