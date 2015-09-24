Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49015 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbbIXLRE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Sep 2015 07:17:04 -0400
Date: Thu, 24 Sep 2015 13:17:02 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Priya Ahuja <priahuja321@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Custom structured data from logger utility
Message-ID: <20150924111702.GD1787@ws.net.home>
References: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
 <CAG27Bk1+WHUEpyn53pGeSyE0bCVgRFnZ0sD17M3MS0p11P8-Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1+WHUEpyn53pGeSyE0bCVgRFnZ0sD17M3MS0p11P8-Pw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 19, 2015 at 09:50:35AM +0100, Sami Kerola wrote:
> I guess custom data could be implemented the same way as it's done with
> journal, e.g., with io vectors.

Well, for --journal we read the data from stdin. I'm not sure if this
is the right way for rfc5424 where we already use stdin to read the
message body. Maybe we can add extra option 

    --structured-data name=value

where you can specify the option more than once.

> Perhaps someone else could take the lead doing in writing these changes,
> would you for example fancy doing that?

I'll try it... ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
