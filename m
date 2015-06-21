Return-Path: martin.petersen@oracle.com
To: Tom Yan <tom.ty89@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: optimal io size / custom alignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
	<20150615133154.GV1992@ws.net.home>
	<CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
	<yq1zj3zfuna.fsf@sermon.lab.mkp.net>
	<CAGnHSEkBXevNmrL7NFO=nKekZdZE6KtzjGvA8sM=onjUfd8KHQ@mail.gmail.com>
	<yq1d20vfimj.fsf@sermon.lab.mkp.net>
	<CAGnHSEnMgivXU_0gDaOkHFkbc=Ve8PaPR0ho8+VhdcUuNu89Gw@mail.gmail.com>
	<yq1a8vwenog.fsf@sermon.lab.mkp.net>
	<CAGnHSE=DGa24TPox8wp4k264jnXjMOq7kzf-tCRf1eJt9kN0ZQ@mail.gmail.com>
Date: Sat, 20 Jun 2015 20:12:43 -0400
In-Reply-To: <CAGnHSE=DGa24TPox8wp4k264jnXjMOq7kzf-tCRf1eJt9kN0ZQ@mail.gmail.com>
	(Tom Yan's message of "Sun, 21 Jun 2015 00:01:34 +0800")
Message-ID: <yq1k2ux9ax0.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <util-linux.vger.kernel.org>

>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:

Tom> I know they all use VPDs, but the main point is whether those
Tom> hardware RAIDs or so are handled by sd_mod, and whether those
Tom> "transfer lengths" info are still important when it's just a simple
Tom> drive. To me they look like to be of different nature.

We don't know whether a discovered device is "a simple drive".

And once again: The whole point of the queue limit is to have an common
abstraction for all block devices.

-- 
Martin K. Petersen	Oracle Linux Engineering
