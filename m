Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64913 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3DJNQt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Apr 2013 09:16:49 -0400
Date: Wed, 10 Apr 2013 15:16:44 +0200
From: Karel Zak <kzak@redhat.com>
To: helmut@hullen.de
Cc: util-linux@vger.kernel.org
Subject: Re: wipefs and zfs
Message-ID: <20130410131644.GE26442@x2.net.home>
References: <CUaVkFE9CXB@helmut.hullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CUaVkFE9CXB@helmut.hullen.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 10, 2013 at 11:26:00AM +0200, Helmut Hullen wrote:
> and "wipefs -o 0x65000 /dev/sdd1" seems to run in an endless loop.

 Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
