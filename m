Return-Path: <SRS0=3eZe=UM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B5C31E45
	for <util-linux@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A67B21743
	for <util-linux@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfFMPLF convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:11:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:27295 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732301AbfFMNvO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 13 Jun 2019 09:51:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 06:51:14 -0700
X-ExtLoop1: 1
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2019 06:51:13 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Jun 2019 06:51:13 -0700
Received: from fmsmsx119.amr.corp.intel.com ([169.254.14.107]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.44]) with mapi id 14.03.0415.000;
 Thu, 13 Jun 2019 06:51:13 -0700
From:   "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: RE: [RFC] utility for SED management
Thread-Topic: [RFC] utility for SED management
Thread-Index: AdUgHzTZHbWrG9gFS1SXimdOtclYpQBP88mAACP9txA=
Date:   Thu, 13 Jun 2019 13:51:12 +0000
Message-ID: <548EA37F71F6AC4BB746F459732504FF7F184907@FMSMSX119.amr.corp.intel.com>
References: <548EA37F71F6AC4BB746F459732504FF7F1810E3@FMSMSX119.amr.corp.intel.com>
 <20190612134005.cb7m2qhgf2aolrf6@ws.net.home>
In-Reply-To: <20190612134005.cb7m2qhgf2aolrf6@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGJmMzFiMjAtMWExYS00NWQ5LWI5ZWYtOTlmY2EwNTUwOWM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNUN5UmlxRm11ZUtuSFJkNUFMVGRyTlo5K3pidHZLRDkrNUgzb2x3VmRxS0xWcDdXXC8zbW9IYTVhRVFoU3RxMUkifQ==
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jun 12, 2019 at 01:40:08PM +0000, Karel Zak wrote:
> From my point of view (and maybe I'm wrong ;-)) it seems complex enough to keep it as an independent stand-alone project ("sed-utils").
> Not sure if it makes sense to push it to generic util-linux package.

It sounds to me that your major concern for inclusion sedcli into util-linux is
its complexity. What would be the best method to understand if sedcli fits into
util-linux?

Thx,
Andrzej

-----Original Message-----
From: util-linux-owner@vger.kernel.org [mailto:util-linux-owner@vger.kernel.org] On Behalf Of Karel Zak
Sent: Wednesday, June 12, 2019 3:40 PM
To: Jakowski, Andrzej <andrzej.jakowski@intel.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] utility for SED management

On Tue, Jun 11, 2019 at 06:30:51AM +0000, Jakowski, Andrzej wrote:
> We have built prototype code covering these functionalities and now we 
> would like to productize it. We are looking for the right place to 
> publish our SW, considering util-linux project as one of the options. 
> The SW will likely consist of:
>  * Libsed - shared object exposing programmatic interface for security
>    management (Opal) of disk
>  * Sedcli - command line utility covering both client and data center flows.
>    Sedcli will use libsed for interaction with the drive, libkmip for
>    interaction with OASIS KMIP based key manager and tpm2-tss to interact with
>    TPM2 key manager
>  * Udev rules - will be used to invoke sedcli to auto-provision or auto-unlock
>    when new device is added to the OS (e.g. hot insert)
>  * System.d  scripts - will be used to invoke sedcli when key needs to be 
>    retrieved from network attached key manager
>  * Config file - will define policies for example on which disk should be 
>    security managed or not
> 
> We would like to contribute that SW into util-linux project. What do 
> you think about adding this SW into util-linux?

From my point of view (and maybe I'm wrong ;-)) it seems complex enough to keep it as an independent stand-alone project ("sed-utils").
Not sure if it makes sense to push it to generic util-linux package.

    Karel

--
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
