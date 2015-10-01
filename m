Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35689 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933248AbbJAM6m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 Oct 2015 08:58:42 -0400
Date: Thu, 1 Oct 2015 14:58:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Priya Ahuja <priahuja321@gmail.com>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: Re: Custom structured data from logger utility
Message-ID: <20151001125840.GF1787@ws.net.home>
References: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 18, 2015 at 04:25:29PM -0700, Priya Ahuja wrote:
> I am using version 2.20.1 logger utility to send logs to rsyslogd from
> bash scripts. I want to send logs in RFC5424 format with custom
> structured data fields, example: [sdid@enterprise-number level=INFO
> id=1234]. I understand 2.20.1 does not support 5424 format but I
> looked at the logger.c code in the latest version and seems structured
> data fields are set to [timeQuality tzKnown=\"1\" isSynced=\"1\"
> syncAccuracy=\"%ld\"]. Is there a way/plan to format custom structured
> data?

Implemented, for example:
 
     logger --rfc5424 --sd-id zoo@123                \
                      --sd-param tiger=\"hungry\"    \
                      --sd-param zebra=\"running\"   \
                      --sd-id manager@123            \
                      --sd-param onMeeting=\"yes\"   \
                      "this is message"
    
produces:
  
     <13>1 2015-10-01T14:07:59.168662+02:00 ws kzak - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="218616"][zoo@123 tiger="hungry" zebra="running"][manager@123 onMeeting="yes"] this is message


The implementation also allows to specify standardized SD-ELEMENTs like
origin, meta and timeQuality (then build-in timeQuality is disabled).

It would be nice to test it against some advanced syslog.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
