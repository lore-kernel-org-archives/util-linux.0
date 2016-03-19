Return-Path: dongli.zhang@oracle.com
MIME-Version: 1.0
Message-ID: <de0b877e-622c-4cd8-887b-38713224c01c@default>
Date: Sat, 19 Mar 2016 05:03:41 -0700 (PDT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: <kzak@redhat.com>
Cc: <util-linux@vger.kernel.org>, <qcai@redhat.com>
Subject: Re: [PATCH 1/1] lscpu: correct the Virtualization type on Xen DomU PV
 guest
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>


> + Is the file always available (including old XEN versions)?=20

This file (/sys/hypervisor/properties/features) has been available since Li=
nux 2.6.31=20
(drivers/xen/sys-hypervisor.c)

> + There is also path_read_u64() to avoid path_fopen() & fscanf().

I will change to path_read_u64.


I also made a new flow to detect the Xen virtualization type according to
the features on this path to maximize the number of versions of existing
Xen and Linux to support. Xen versions from Xen 3.3.0 to the current Xen
unstable would be able to help detect PV based on
XENFEAT_mmu_pt_update_preserve_ad. Xen versions from Xen 4.4.0 to the
newest would be able to help detect PVH (which has been introduced since
Xen 4.4.0).

if cpuid returns XenVMMXenVMM
=09virtype =3D full
=09if _PATH_SYS_HYP_FEATURES (the file) exists
=09=09if XENFEAT_mmu_pt_update_preserve_ad is set (supported since Xen 3.3.=
0)
=09=09=09virtype =3D para
=09=09else if XENFEAT_supervisor_mode_kernel is set and
=09=09=09=09XENFEAT_hvm_callback_vector is set (supported since Xen 4.4.0)
=09=09=09virtype =3D para
=09=09end if
=09end if
end if

Please let me know your feedback and suggestion so that I would send the
new patch soon.

Dongli Zhang
