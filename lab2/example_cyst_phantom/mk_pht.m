%  Make the scatteres for a simulation and store
%  it in a file for later simulation use

%   Joergen Arendt Jensen, Feb. 26, 1997



%[phantom_positions,   phantom_amplitudes]   = cyst_pht(1e4);

% Generate background scatterers (do NOT shift them)
[phantom_positions, phantom_amplitudes] = cyst_pht(1e4);

% ── Cysts at x = -5 mm: zero out scatterers inside each cyst ─────────────────
radii     = [5e-3, 3e-3, 1e-3];
z_centers = [20e-3, 40e-3, 60e-3];

for i = 1:3
    dist_cyst = sqrt( (phantom_positions(:,1) - (-5e-3)).^2 + ...
                      (phantom_positions(:,3) -  z_centers(i)).^2 );
    phantom_amplitudes(dist_cyst < radii(i)) = 0;
end

% ── High-scattering objects at x = +5 mm: amplify scatterers inside ──────────
for i = 1:3
    dist_high = sqrt( (phantom_positions(:,1) - 5e-3).^2 + ...
                      (phantom_positions(:,3) - z_centers(i)).^2 );
    phantom_amplitudes(dist_high < radii(i)) = phantom_amplitudes(dist_high < radii(i)) * 10;
end

save ph_data.mat phantom_positions phantom_amplitudes
save ph_data.mat phantom_positions phantom_amplitudes
%{
%Move cysts to x = -5 mm
phantom_positions(:,1) = phantom_positions(:,1) - 5e-3;

radii    = [5e-3, 3e-3, 1e-3];     % 5, 3 and 1 mm
z_centers = [20e-3, 40e-3, 60e-3]; % same depths cyst_pht uses
x_high   = 5e-3;                   % place them at x = +5


for i = 1:3
    % Euclidean distance in the x-z plane from each scatterer to the object centre
    dist = sqrt( (phantom_positions(:,1) - x_high).^2 + ...
                 (phantom_positions(:,3) - z_centers(i)).^2 );

    % Any scatterer inside the radius gets its amplitude multiplied by 10
    inside = dist < radii(i);
    phantom_amplitudes(inside) = phantom_amplitudes(inside) * 10;
end
%}
save pht_data.mat phantom_positions phantom_amplitudes