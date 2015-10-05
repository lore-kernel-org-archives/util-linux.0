Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbbJEM7e (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Oct 2015 08:59:34 -0400
Date: Mon, 5 Oct 2015 14:59:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Priya Ahuja <priahuja321@gmail.com>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: Re: Custom structured data from logger utility
Message-ID: <20151005125932.GA32529@ws.net.home>
References: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
 <20151001125840.GF1787@ws.net.home>
 <CAGQyBevj8+L6rMigOXQQw7t=iR9s-PMbbOLf40wu=P7212dCMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGQyBevj8+L6rMigOXQQw7t=iR9s-PMbbOLf40wu=P7212dCMw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 02, 2015 at 11:43:30AM -0700, Priya Ahuja wrote:
> Thanks for the changes. Is there a reason for keeping pre-set
> structured data elements like timeQuality, tzKnown if custom data is
> provided?

I don't think uses want to generate things like timeQuality by shell 
on logger command line. IMHO "--sd-id timeQuality" will be used very
rarely (but it's possible and supported use case).

The another thing is that we already released logger with build-in
timeQuality and we have to keep it for backward compatibility.

> Also if the SD-ID is the same, it would make more sense
> merging the structured data into one, what do you think?

You have to use unique SD-ID and use it only once. It's pretty simple
semantic, I'm not sure if need something more complicated/complex.
(Or do you mean something else?)

For example:

 --sd-id zoo@123                \
 --sd-param tiger=\"hungry\"    \
 --sd-param zebra=\"running\"   \
 --sd-id manager@123            \
 --sd-param onMeeting=\"yes\" 


sd-id command line option works as separator between the elements, so
it generates two SD-ELEMENTS:

  [zoo@123 tiger="hungry" zebra="running"]
  [manager@123 onMeeting="yes"]


 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
