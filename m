Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48199 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab3EISxt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 May 2013 14:53:49 -0400
Date: Thu, 9 May 2013 20:53:44 +0200
From: Karel Zak <kzak@redhat.com>
To: George Mitchell <george@chinilu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
Message-ID: <20130509185344.GA9821@x2.net.home>
References: <51882EA5.9080805@chinilu.com>
 <20130507094835.GB7086@x2.net.home>
 <51891448.5010804@chinilu.com>
 <20130509094226.GD17527@x2.net.home>
 <518BAD64.6080704@chinilu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <518BAD64.6080704@chinilu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 09, 2013 at 07:06:28AM -0700, George Mitchell wrote:
> So what I think I hear you saying on this issue is that though I can easily
> turn a label into a mount point with my little grep trick, umount is unable
> to do that so that in my scripts I will always have to use this kluge for
> things to work correctly?  And that of course the same would hold true with
> findmnt?

 Yes, this is not btrfs issue only, this is a generic problem:


  mount LABEL=foo  /A
  mount LABEL=foo  /B

  umount LABEL=foo

 .. do you want to umount /A or /B  ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
