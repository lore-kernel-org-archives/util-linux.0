Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbaGOHf7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 03:35:59 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6F7Zv1p014860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2014 03:35:58 -0400
Message-ID: <53C4D9DB.10703@redhat.com>
Date: Tue, 15 Jul 2014 09:35:55 +0200
From: Stef Walter <stefw@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive
 SIGUSR1
References: <1404718284-4192-1-git-send-email-stefw@redhat.com> <20140714133716.GB30288@x2.net.home>
In-Reply-To: <20140714133716.GB30288@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 14.07.2014 15:37, Karel Zak wrote:
> On Mon, Jul 07, 2014 at 09:31:24AM +0200, Stef Walter wrote:
>> Several of the /etc/issue escape codes such as \4 and \S depend on
>> variable data which can change after the agetty prompt is displayed.
>> This can cause stale data to be displayed when a user looks at a VT,
>> especially in cases of DHCP racing with system start up.
>>
>> This commit allows agetty to react a SIGUSR1 signal by reprinting
>> its prompt including the reprocessing of /etc/issue.
>>
>> We never want this to occur once the user has started typing a
>> user name. So we detect when the user starts typing, after which
>> no further reprompting occurs even if SIGUSR1 is received.
> 
>  Good idea, interesting implementation, but it's too late for v2.25.
>  I'm going to apply the patch to the git tree after v2.25 release.

Nice. Thanks.

Lennart discovered an issue with this ...

That the exec'ing the login process might race with the SIGUSR1 signal.
The fix here would be to signal(SIGUSR1, SIG_IGN) before exec'ing, does
that sound appropriate? I can post a new patch.

By the way, more information about this use case here:
https://bugzilla.redhat.com/show_bug.cgi?id=1110763

Also, on the use of SIGUSR1 ... often linux daemons like to use SIGHUP
as a 'reload' signal. But obviously this signal already has specific
meaning in the agetty case, hence the choice of SIGUSR1.

Cheers,

Stef

