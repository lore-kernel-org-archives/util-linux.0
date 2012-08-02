Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39860 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900Ab2HBJqo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Aug 2012 05:46:44 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q729kiOX003533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 2 Aug 2012 05:46:44 -0400
Message-ID: <501A4C82.5030509@redhat.com>
Date: Thu, 02 Aug 2012 11:46:42 +0200
From: Niels de Vos <ndevos@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [RFC] mount: overwrite options from /etc/fstab when given on
 the commandline
References: <1343812301-24896-1-git-send-email-ndevos@redhat.com> <20120801094833.GC1019@x2.net.home> <20120801100316.GD1019@x2.net.home> <5019017E.4050704@redhat.com> <20120801103248.GA7670@x2.net.home> <501919F4.3040403@redhat.com> <20120801170837.GA21273@x2.net.home>
In-Reply-To: <20120801170837.GA21273@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/01/2012 07:08 PM, Karel Zak wrote:
>>>> On 08/01/2012 12:03 PM, Karel Zak wrote:
>>>>> Maybe we can also add another exception for SELinux to de-duplicate
>>>>> the SELinux context options in the options string. It's not perfect,
>>>>> but probably acceptable for SELinux -- I can do this for 2.22-rc2.
>
> Implemented (for libmount) in the master branch. You can try it:
>
>    ./autogen.sh
>    ./configure
>    make mount
>
>    ./mount -o ...

Great! It works for me on Fedora Rawhide when I add --with-selinux to ./configure.

Thanks for your fast responses and implementation,
Niels
