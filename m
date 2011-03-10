Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.redfish-solutions.com ([66.232.79.143]:59426 "EHLO
	mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751158Ab1CJWfE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Mar 2011 17:35:04 -0500
Message-ID: <4D794E28.4050001@redfish-solutions.com>
Date: Thu, 10 Mar 2011 14:18:16 -0800
From: Philip Prindeville <philipp@redfish-solutions.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Adding --color option to script?
References: <4D13CC3E.9000000@redfish-solutions.com> <20101231000329.GB17311@nb.net.home>
In-Reply-To: <20101231000329.GB17311@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/30/10 4:03 PM, Karel Zak wrote:
> On Thu, Dec 23, 2010 at 02:25:02PM -0800, Philip Prindeville wrote:
>> I would love to see an option like --color which used terminal
>> colors to highlight STDERR output (or, in a pinch, maybe bold it on
>> terminals that don't support color... if they still exist).
>   The script(1) command does not work on this level. It reads data
>   directly from master side of the terminal. It means that we are not
>   able to distinguish between stdout and stderr.
>
>> Sound reasonable?
>   Yes, but I don't see a way how to implement it.
>
>      Karel
>

I just realized...  it can be done by having two ptys, one for stdin/stdout, and another just for stderr.

-Philip

