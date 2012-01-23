Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47486 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab2AWNho (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 Jan 2012 08:37:44 -0500
Received: by iacb35 with SMTP id b35so3758629iac.19
        for <util-linux@vger.kernel.org>; Mon, 23 Jan 2012 05:37:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120123.222636.550210626606480400.yamato@redhat.com>
References: <CAPXgP11pvch92n1=mMfDsMLoGZMG8xq0e1juXyUO6mxFR6_GYg@mail.gmail.com>
 <20120123122115.GA29250@x2.net.home> <CAPXgP11WMG1Q53scWXqQnktOyUZbY5K09KRfRaT3ct-Y78yULA@mail.gmail.com>
 <20120123.222636.550210626606480400.yamato@redhat.com>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Mon, 23 Jan 2012 14:37:22 +0100
Message-ID: <CAPXgP10LHyDJt_v5w1JyY4q0ouunVxJHr3QLgdL5VBPG28qOBQ@mail.gmail.com>
Subject: Re: /etc/fstab.d yes or not
To: Masatake YAMATO <yamato@redhat.com>
Cc: kzak@redhat.com, rleigh@codelibre.net, util-linux@vger.kernel.org,
        ssato@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 23, 2012 at 14:26, Masatake YAMATO <yamato@redhat.com> wrote:

> What I want is packaging the system mounts.
> Consider setting up multiple hosts which mount the same nfs filesystem
> to the same mount point. It the mount point is in a rpm package, it
> can be used both in kickstart file and from yum command line. In
> addition yum update can be used when the name or ip of nfs server is
> changed; Just create the new release of the rpm package which holds
> new mount point deification. In stead of nfs, you can consider smb or
> iso images as examples.

That sounds very wrong to do. This is admin territory and not package
management. There are tools sync and deploy /etc setting per-machine
across big networks, and RPM is surely not the right thing to use
here.

RPM is for the operating system, not for host configuration. Most
stuff in /etc is marked as config for that exact reason. First, static
system-config does not belong in /etc, second non-admin editable files
just do not belong in /etc. It's all wrong, just as the misguided
entire fstab.d/ feature to start with.

Kay
